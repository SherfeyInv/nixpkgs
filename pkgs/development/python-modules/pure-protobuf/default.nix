{
  lib,
  buildPythonPackage,
  pythonOlder,
  fetchFromGitHub,
  poetry-core,
  poetry-dynamic-versioning,
  typing-extensions,
  pytestCheckHook,
  pytest-benchmark,
  pytest-cov,
  pydantic,
}:

buildPythonPackage rec {
  pname = "pure-protobuf";
  version = "3.1.1";

  format = "pyproject";
  # < 3.10 requires get-annotations which isn't packaged yet
  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "eigenein";
    repo = "protobuf";
    rev = "refs/tags/${version}";
    hash = "sha256-xcW6ODL0UqwVesqIUxxzN5EuXK8hE4rY1inatuM1UpI=";
  };

  build-system = [
    poetry-core
    poetry-dynamic-versioning
    typing-extensions
  ];

  dependencies = [ typing-extensions ];

  nativeCheckInputs = [
    pydantic
    pytestCheckHook
    pytest-benchmark
    pytest-cov
  ];

  pytestFlagsArray = [ "--benchmark-disable" ];

  pythonImportsCheck = [ "pure_protobuf" ];

  meta = with lib; {
    description = "Python implementation of Protocol Buffers with dataclass-based schemas";
    homepage = "https://github.com/eigenein/protobuf";
    changelog = "https://github.com/eigenein/protobuf/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ chuangzhu ];
  };
}
