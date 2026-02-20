import "@forma/ui-lib";
import "forma-embedded-view-sdk";
import "forma-embedded-view-sdk/auto";
import init from "../pkg/{{ crate_name }}.js";
import "./style.css";

const app = document.querySelector("#app");

app.innerHTML = `<pre id="status">Initializing...</pre>`;

const status = document.querySelector("#status");

let wasmInstancePromise = null;

async function launchExtension() {
  status.textContent = "Loading extension...";
  try {
    wasmInstancePromise ??= init();
    const wasm = await wasmInstancePromise;
    wasm.launch();
  } catch (error) {
    status.textContent = `Launch failed: ${String(error)}`;
    wasmInstancePromise = null;
  }
}

void launchExtension();
