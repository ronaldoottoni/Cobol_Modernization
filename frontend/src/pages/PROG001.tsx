import { useState } from "react";
import { callCobol } from "../api/cobolApi";

export default function SGN001() {
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [document, setDocument] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");

  async function recordAccess() {
    const data = id.padStart(9, "0");
    const result = await callCobol(
      "PROG001",
      "ACESSAR-REGISTRO",
      data
    );
    setName(result.name);
    setDocument(result.document);
    setEmail(result.email);
    setPhone(result.phone);
  }

  return (
    <div>

      <h2>Customers - SGN001</h2>

      <div>
        ID
        <input
          value={id}
          onChange={(e) => setId(e.target.value)}
        />
        <button onClick={recordAccess}>
          Access
        </button>
      </div>

      <div>
        Name
        <input value={name} />
      </div>

      <div>
        Document
        <input value={document} />
      </div>

      <div>
        Email
        <input value={email} />
      </div>

      <div>
        Phone
        <input value={phone} />
      </div>

    </div>
  );
}