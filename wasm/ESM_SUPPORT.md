# ESM Support for StyLua WASM

This is a fork of StyLua that adds proper ES Module (ESM) support alongside the existing CommonJS support.

## Changes Made

1. **Dual Module Support**: The package now supports both ESM and CommonJS imports
2. **Proper Export Conditions**: Updated `package.json` exports to correctly handle both module systems
3. **Build Process**: Enhanced build script to generate both `.cjs` and `.mjs` entry points
4. **Type Definitions**: Updated TypeScript definitions for both module systems

## Usage

### ESM (ES Modules)
```javascript
import { formatCode, Config } from '@christopher-buss/stylua';

const config = new Config();
const formatted = formatCode('local x=1', config);
```

### CommonJS
```javascript
const { formatCode, Config } = require('@christopher-buss/stylua');

const config = new Config();
const formatted = formatCode('local x=1', config);
```

## Package Structure

- `stylua_lib.mjs` - ESM entry point
- `stylua_lib.cjs` - CommonJS entry point
- `stylua.web/` - Generated WASM files and base JavaScript
- `stylua_lib.d.mts` - TypeScript definitions for ESM
- `stylua_lib.d.cts` - TypeScript definitions for CommonJS

## Building

Run the build script to generate both module formats:

```bash
./wasm/build-wasm.sh
```

This will:
1. Compile Rust to WASM using wasm-pack
2. Generate base ESM JavaScript from WASM
3. Create CommonJS wrapper
4. Create ESM wrapper with proper Node.js integration
5. Generate appropriate TypeScript definitions