#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${PROFILE:-release}"
CRATE_NAME="${CRATE_NAME:-{{ crate_name }}}"
OUT_DIR="${OUT_DIR:-$ROOT_DIR/dist}"

if ! command -v wasm-pack >/dev/null 2>&1; then
  echo "error: wasm-pack is required. Install with: cargo install wasm-pack" >&2
  exit 1
fi

mkdir -p "$OUT_DIR"
if [[ "$PROFILE" == "release" ]]; then
  wasm-pack build "$ROOT_DIR" --release --target web --out-dir "$OUT_DIR" --out-name "$CRATE_NAME"
else
  wasm-pack build "$ROOT_DIR" --dev --target web --out-dir "$OUT_DIR" --out-name "$CRATE_NAME"
fi

echo "Generated:"
echo "  $OUT_DIR/$CRATE_NAME.js"
echo "  $OUT_DIR/${CRATE_NAME}_bg.wasm"
