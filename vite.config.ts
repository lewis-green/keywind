import { defineConfig } from 'vite';

export default defineConfig({
  base: '',
  build: {
    rollupOptions: {
      input: [
        'src/index.ts',
        'src/data/recoveryCodes.ts',
        'src/data/webAuthnAuthenticate.ts',
        'src/data/webAuthnRegister.ts',
      ],
      output: {
        assetFileNames: (chunkInfo) => chunkInfo.name.indexOf(".otf") > -1 ? 'fonts/[name][extname]' : '[name][extname]', //'css/[name][extname]',
        dir: 'theme/keywind/login/resources/dist',
        entryFileNames: '[name].js',
      },
    },
  }
});
