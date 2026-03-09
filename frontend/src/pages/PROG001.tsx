import { useState, useRef } from "react";
import { callCobol } from "../api/cobolApi";

export default function SGN001() {
  const [id, setId] = useState("");
  const [name, setName] = useState("");
  const [document, setDocument] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");

  const idRef = useRef<HTMLInputElement>(null);

  function handleEnter(
    e: React.KeyboardEvent<HTMLInputElement>,
    lastField: boolean = false
  ) {
    if (e.key !== "Enter") return;

    e.preventDefault();

    if (lastField) {
      callFunction("RECORD-SAVE");
      return;
    }

    const form = e.currentTarget.form;
    if (!form) return;

    const index = Array.prototype.indexOf.call(form, e.currentTarget);
    const next = form.elements[index + 1] as HTMLElement;

    next?.focus();
  }

  function buildScreenData() {
    return (
      id.padStart(9, "0") +
      name.padEnd(60, " ") +
      document.padEnd(25, " ") +
      email.padEnd(150, " ") +
      phone.padStart(9, "0")
    );
  }

  async function callFunction(func: string) {
    const result = await callCobol(
      "PROG001",
      func,
      buildScreenData()
    );

    if (!result) return;

    setName(result.name ?? "");
    setDocument(result.document ?? "");
    setEmail(result.email ?? "");
    setPhone(result.phone ?? "");
  }

  function clearScreen() {
    setId("");
    setName("");
    setDocument("");
    setEmail("");
    setPhone("");

    idRef.current?.focus();
  }

  return (
    <div className="form">

      <h2>Customers - PROG001</h2>

      <div className="field">
        <label>ID</label>
        <input
          ref={idRef}
          value={id}
          onChange={(e) => setId(e.target.value)}
          onKeyDown={(e) => handleEnter(e)}
        />
        <button onClick={() => callFunction("RECORD-ACCESS")}>Access</button>
      </div>

      <div className="field">
        <label>Name</label>
        <input
          value={name}
          onChange={(e) => setName(e.target.value)}
          onKeyDown={(e) => handleEnter(e)}
        />
      </div>

      <div className="field">
        <label>Document</label>
        <input
          value={document}
          onChange={(e) => setDocument(e.target.value)}
          onKeyDown={(e) => handleEnter(e)}
        />
      </div>

      <div className="field">
        <label>Email</label>
        <input
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          onKeyDown={(e) => handleEnter(e)}
        />
      </div>

      <div className="field">
        <label>Phone</label>
        <input
          value={phone}
          onChange={(e) => setPhone(e.target.value)}
          onKeyDown={(e) => handleEnter(e)}
        />
      </div>
      <div className="buttons">
        <button onClick={() => callFunction("RECORD-SAVE")}>Save</button>
        <button onClick={clearScreen}>Clean</button>
      </div>

    </div>
  );
}