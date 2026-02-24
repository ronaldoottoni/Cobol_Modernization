import express, { Request, Response } from "express";
import cors from "cors";
import { execFile } from "child_process";
import path from "path";

const app = express();
app.use(cors());
app.use(express.json());

app.get("/api/progweb", (req: Request, res: Response) => {
  const exePath = path.resolve(
    __dirname,
    "../../cobol/objects/PROGWEB.exe"
  );

  const parametersValue = "DADO-ENVIADO-PELO-NODE";

  execFile(
    exePath,
    [],
    {
      env: {
        ...process.env,
        PARAMETERS: parametersValue
      }
    },
    (error, stdout, stderr) => {
      if (error) {
        console.error("Erro ao executar COBOL:", error);
        return res.status(500).json({ erro: "Erro ao executar COBOL" });
      }

      const retorno = stdout.trim();

      res.json({ retorno });
    }
  );
});

app.listen(3000, () => {
  console.log("Servidor rodando na porta 3000");
});