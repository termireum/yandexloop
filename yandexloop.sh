#!/usr/bin/env bash

set -euo pipefail

TARGET="${1:-}"

if [ -z "$TARGET" ]; then
  echo "Usage: ./yadexloop.sh example.com"
  exit 1
fi

TARGET_CLEAN=$(echo "$TARGET" | sed 's#https://##;s#http://##;s#/.*##')
OUTDIR="yandex-loop-output/$TARGET_CLEAN"

mkdir -p "$OUTDIR"

DORKS=(
  "site:$TARGET_CLEAN /api/"
  "site:$TARGET_CLEAN graphql"
  "site:$TARGET_CLEAN swagger"
  "site:$TARGET_CLEAN openapi"
  "site:$TARGET_CLEAN redoc"
  "site:$TARGET_CLEAN admin"
  "site:$TARGET_CLEAN login"
  "site:$TARGET_CLEAN dashboard"
  "site:$TARGET_CLEAN staging"
  "site:$TARGET_CLEAN dev"
  "site:$TARGET_CLEAN test"
  "site:$TARGET_CLEAN beta"
  "site:$TARGET_CLEAN internal"
  "site:$TARGET_CLEAN _next/static"
  "site:$TARGET_CLEAN _next/data"
  "site:$TARGET_CLEAN chunk.js"
  "site:$TARGET_CLEAN app.js"
  "site:$TARGET_CLEAN main.js"
  "site:$TARGET_CLEAN firebase"
  "site:$TARGET_CLEAN s3.amazonaws.com"
  "site:$TARGET_CLEAN config"
  "site:$TARGET_CLEAN token"
  "site:$TARGET_CLEAN secret"
  "site:$TARGET_CLEAN password"
  "site:$TARGET_CLEAN filetype:json"
  "site:$TARGET_CLEAN filetype:xml"
  "site:$TARGET_CLEAN filetype:txt"
  "site:$TARGET_CLEAN filetype:log"
  "site:$TARGET_CLEAN filetype:pdf"
)

echo "[*] Target: $TARGET_CLEAN"
echo "[*] Output: $OUTDIR"
echo "[*] Running Yandex dork loop..."

RAW="$OUTDIR/raw_urls.txt"
FINAL="$OUTDIR/urls.txt"

: > "$RAW"

for DORK in "${DORKS[@]}"; do
  echo "[→] $DORK"

  QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote_plus('$DORK'))")

  curl -ksL \
    -A "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome Safari/537.36" \
    "https://yandex.com/search/?text=$QUERY" \
    | grep -Eo 'https?://[^"<> ]+' \
    | sed 's/&amp;/\&/g' \
    | grep -i "$TARGET_CLEAN" \
    >> "$RAW" || true

  sleep 5
done

cat "$RAW" \
  | sed 's/#.*//' \
  | sed 's/[),;]*$//' \
  | sort -u \
  > "$FINAL"

grep -Ei '/api/|graphql|swagger|openapi|redoc' "$FINAL" > "$OUTDIR/api.txt" || true
grep -Ei '_next|\.js|chunk|webpack|static' "$FINAL" > "$OUTDIR/javascript.txt" || true
grep -Ei 'admin|login|dashboard|signin|auth' "$FINAL" > "$OUTDIR/auth_admin.txt" || true
grep -Ei 'staging|dev|test|beta|internal' "$FINAL" > "$OUTDIR/environments.txt" || true
grep -Ei '\.json|\.xml|\.txt|\.log|\.env' "$FINAL" > "$OUTDIR/files.txt" || true
grep -Ei '\.pdf|\.doc|\.docx|\.xls|\.xlsx|\.csv' "$FINAL" > "$OUTDIR/documents.txt" || true

echo ""
echo "[✅] Done"
echo "[*] Total URLs: $(wc -l < "$FINAL")"
echo "[*] Saved to: $FINAL"
echo ""
echo "Buckets:"
echo "  API:          $(wc -l < "$OUTDIR/api.txt" 2>/dev/null || echo 0)"
echo "  JavaScript:   $(wc -l < "$OUTDIR/javascript.txt" 2>/dev/null || echo 0)"
echo "  Auth/Admin:   $(wc -l < "$OUTDIR/auth_admin.txt" 2>/dev/null || echo 0)"
echo "  Environments: $(wc -l < "$OUTDIR/environments.txt" 2>/dev/null || echo 0)"
echo "  Files:        $(wc -l < "$OUTDIR/files.txt" 2>/dev/null || echo 0)"
echo "  Documents:    $(wc -l < "$OUTDIR/documents.txt" 2>/dev/null || echo 0)"
