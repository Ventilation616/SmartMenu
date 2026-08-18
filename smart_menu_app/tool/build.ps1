param(
  [Parameter(Mandatory = $true)]
  [ValidateSet('pub-get', 'codegen', 'analyze', 'test')]
  [string]$Task
)

switch ($Task) {
  'pub-get' {
    flutter pub get
  }
  'codegen' {
    dart run build_runner build
  }
  'analyze' {
    flutter analyze
  }
  'test' {
    flutter test
  }
}
