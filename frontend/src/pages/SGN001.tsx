import { useState } from "react";

export default function SGN001() {
  const [codigo, setCodigo] = useState("");
  const [name, setName] = useState("");
  const [document, setDocument] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");

  const consultar = async () => {
    if (!codigo) {
      alert("Informe o código");
      return;
    }

    const codigoFormatado = codigo.padStart(9, "0");

    const response = await fetch("http://localhost:3000/api/exec", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        program: "SGN001",
        data: codigoFormatado,
      }),
    });

    const data = await response.json();

    if (data.error) {
      alert(data.error);
      return;
    }

    setName(data.name);
    setDocument(data.document);
    setEmail(data.email);
    setPhone(data.phone);
  };

  return (
    <div style={{ padding: 20 }}>
      <h2>SGN001 - Consulta</h2>

      <div>
        <input
          placeholder="Código"
          value={codigo}
          onChange={(e) => setCodigo(e.target.value)}
        />
        <button onClick={consultar}>Consultar</button>
      </div>

      <hr />

      <div>
        <input placeholder="Nome" value={name} readOnly />
        <input placeholder="Documento" value={document} readOnly />
        <input placeholder="Email" value={email} readOnly />
        <input placeholder="Telefone" value={phone} readOnly />
      </div>
    </div>
  );
}