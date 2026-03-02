import express, { Request, Response } from "express";
import cors from "cors";
import { execFile } from "child_process";
import path from "path";

const app = express();

app.use(cors());
app.use(express.json());

function buildSysParam(params: {
    flagWeb?: string;
    ttyWeb?: string;
    usernameWeb?: string;
    dateWeb?: string;
    timeWeb?: string;
    functionWeb?: string;
    functionBackWeb?: string;
    flagFunctionWeb: string;
    fillerWeb: string;
}) {
    const buffer = new Array(200).fill(" ");
    const write = (value: string, start: number, length: number) => {
        const formatted = (value || "").toUpperCase().padEnd(length, " ");
        for (let i = 0; i < length; i++) {
            buffer[start + i] = formatted[i] || " ";
        }
    };

    const now = new Date();
    const date =
        now.getFullYear().toString() +
        String(now.getMonth() + 1).padStart(2, "0") +
        String(now.getDate()).padStart(2, "0");
    const time =
        String(now.getHours()).padStart(2, "0") +
        String(now.getMinutes()).padStart(2, "0") +
        String(now.getSeconds()).padStart(2, "0") +
        "00";

    // WK-FLAG-WEB (posição 1)
    write("S", 0, 1);

    // WK-TTY (posição 2)
    write(params.ttyWeb || "WEB", 1, 10);

    // WK-USERNAME (posição 12)
    write(params.usernameWeb || "", 11, 10);

    // WK-CALL-DATE (posição 22)
    write(date, 21, 8);

    // WK-CALL-TIME (posição 30)
    write(time, 29, 8);

    // WK-FUNCTION (posição 38)
    write(params.functionWeb || "", 37, 20);

    // WK-FUNCTION-BACK (posição 58)
    write("", 57, 20);

    // WK-FLAG-FUNCTION (posição 78)
    write("", 77, 1);
}

app.post("/api/exec", (req: Request, res: Response) => {
    const exePath = path.resolve(
        __dirname,
        "../../cobol/objects/PROGWEB.exe"
    );

    const { program, func, sysParams, data } = req.body;

    if (!program || !func) {
        return res.status(400).json({
            error: "Campos 'program' e 'func' são obrigatórios",
        });
    }

    // PADRÕES FIXOS
    const programName = program.toUpperCase().padEnd(10, " ");
    const functionName = func.toUpperCase().padEnd(30, " ");
    const systemParams = (sysParams || "").padEnd(200, " ");

    const finalParameters =
        programName + functionName + systemParams + (data || "");

    execFile(
        exePath,
        [],
        {
            cwd: path.resolve(__dirname, "../../cobol/objects"),
            env: {
                ...process.env,
                PARAMETERS: finalParameters,
            },
        },
        (error, stdout, stderr) => {
            if (error) {
                console.error("ERRO COMPLETO:", error);
                return res.status(500).json({
                    error: "Erro ao executar COBOL",
                    details: error.message
                });
            }

            const output = stdout.trim();

            if (!output) {
                return res.status(500).json({
                    error: "COBOL não retornou conteúdo",
                });
            }

            try {
                const json = JSON.parse(output);
                return res.json(json);
            } catch {
                return res.status(500).json({
                    error: "Retorno inválido do COBOL",
                    raw: output,
                });
            }
        }
    );
});

app.listen(3000, () => {
    console.log("Servidor rodando na porta 3000");
});