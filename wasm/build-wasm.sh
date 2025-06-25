#!/bin/bash

# Copy necessary files
cp README.md wasm/
cp LICENSE.md wasm/

# Build WASM with wasm-pack
npx wasm-pack@0.10.3 build --target web --out-dir wasm/stylua.web -- --features lua52,lua53,lua54,luajit,luau,cfxlua

# Add exports for bundler usage
echo "export { __wbg_get_imports as __getImports, __wbg_finalize_init as __finalizeInit }" >> wasm/stylua.web/stylua_lib.js

# Build CommonJS version using locally installed rollup with plugins
cd wasm && ./node_modules/.bin/rollup src/stylua_lib_node_cjs.mjs --file stylua_lib.cjs --format cjs \
  --external 'node:fs' --external 'node:path' --external 'node:url' \
  --plugin @rollup/plugin-node-resolve --plugin @rollup/plugin-commonjs
cd ..

# Build ESM version using locally installed rollup
cd wasm && ./node_modules/.bin/rollup src/stylua_lib_node_esm.mjs --file stylua_lib.mjs --format es \
  --external 'node:fs' --external 'node:path' --external 'node:url'
cd ..

echo "Build complete! Generated both ESM (.mjs) and CommonJS (.cjs) modules using rollup."