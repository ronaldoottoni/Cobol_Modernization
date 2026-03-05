export async function callCobol(program: string, func: string, data: string) {
    const res = await fetch("http://localhost:3000/api/exec", {
        method: "POST",
        headers:{
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            program,
            func,
            data
        })
    });

    return res.json();
}