module.exports = {
  globalSetup: './jest.globalSetup.js',
  moduleFileExtensions: [
    "ts",
    "js"
  ],
  transform: {
    "\\.ts$": "ts-jest"
  },
  testRegex: ".*.test\\.(ts|js)"
}
