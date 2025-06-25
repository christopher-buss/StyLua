// This file will be processed by rollup to generate CommonJS
import { readFileSync } from 'node:fs';
import { join, dirname } from 'node:path';
import { fileURLToPath } from 'node:url';
import { initSync } from '../stylua.web/stylua_lib.js';

// These will be transformed by rollup for CommonJS compatibility
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

// Load and initialize the WASM module
const wasmPath = join(__dirname, 'stylua.web', 'stylua_lib_bg.wasm');
const wasmBytes = readFileSync(wasmPath);
initSync(wasmBytes);

// Re-export everything from the WASM library
export * from '../stylua.web/stylua_lib.js';