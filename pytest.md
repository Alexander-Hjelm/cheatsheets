# pytest Cheat Sheet

<!--ts-->
<!--te-->

## Video (with minimal application example)

<https://www.youtube.com/watch?v=cHYq1MRoyI0>

## Installation

```sh
pip install pytest
```

## Test file/method name convention, auto-discovery

```sh
test_<file name>.py
test_<method name>.py
```

## Running Tests

```sh
pytest              # Run all tests
pytest test_module.py  # Run tests in a specific file
pytest -k "keyword"  # Run tests matching the keyword
pytest -m "mark"     # Run tests with the specific mark
pytest --maxfail=2   # Stop after 2 failures
pytest -v            # Verbose output
```

## Simple Unit Tests

```python
def test_add():
    assert add(1, 2) == 3

def test_subtract():
    assert subtract(2, 1) == 1
```

## Class-Based Tests

```python
class TestMath:
    def test_add(self):
        assert add(1, 2) == 3

    def test_subtract(self):
        assert subtract(2, 1) == 1
```

## Function-Level Setup and Teardown
Use `setup_function` and `teardown_function` for function-level setup and teardown.

```python
def setup_function(function):
    print(f"Setup for {function.__name__}")

def teardown_function(function):
    print(f"Teardown for {function.__name__}")

def test_func1():
    assert True

def test_func2():
    assert True
```

## Fixtures

Fixtures provide a way to initialize resources needed for tests.

```python
import pytest

@pytest.fixture
def setup_data():
    return {"key": "value"}

def test_data(setup_data):
    assert setup_data["key"] == "value"
```

## Mark and Parameterize

### Marking Tests

```python
import pytest

@pytest.mark.slow
def test_long_running():
    pass
```

### Parameterizing Tests

```python
import pytest

@pytest.mark.parametrize("a,b,expected", [(1, 2, 3), (4, 5, 9)])
def test_add(a, b, expected):
    assert add(a, b) == expected
```

## Mocking

### Using `unittest.mock`

```python
from unittest.mock import MagicMock

def test_with_mock():
    mock = MagicMock(return_value=3)
    result = mock(1, 2)
    assert result == 3
    mock.assert_called_once_with(1, 2)
```

### Using `pytest-mock`

Install `pytest-mock`:

```sh
pip install pytest-mock
```

```python
def test_with_pytest_mock(mocker):
    mock = mocker.patch('module.Class.method', return_value=3)
    result = module.Class().method(1, 2)
    assert result == 3
    mock.assert_called_once_with(1, 2)
```

### Mocking web requests

```python
@patch('requests.get')
def test_fetch_data(mock_get):
    # Configure the mock to return a response with a status code of 200
    mock_get.return_value.status_code = 200
    mock_get.return_value.json.return_value = {'key': 'value'}
    
    # Call the function to be tested
    result = fetch_data('https://api.example.com/data')
    
    # Assert that the function returns the expected result
    assert result == {'key': 'value'}
    
    # Assert that requests.get was called with the expected URL
    mock_get.assert_called_once_with('https://api.example.com/data')

@patch('requests.get')
def test_fetch_data_failure(mock_get):
    # Configure the mock to return a response with a status code other than 200
    mock_get.return_value.status_code = 404
    
    # Call the function to be tested
    result = fetch_data('https://api.example.com/data')
    
    # Assert that the function returns None for a non-200 status code
    assert result is None
    
    # Assert that requests.get was called with the expected URL
    mock_get.assert_called_once_with('https://api.example.com/data')

```

## Custom Marks

```python
import pytest

@pytest.mark.custom_mark
def test_custom():
    pass

# Running tests with the custom mark
# pytest -m custom_mark
```

## Skipping Tests

```python
import pytest

@pytest.mark.skip(reason="Not implemented yet")
def test_not_implemented():
    pass

@pytest.mark.skipif(condition, reason="Conditional skip")
def test_conditional():
    pass
```

## Expected Failures

```python
import pytest

@pytest.mark.xfail(reason="Known bug")
def test_known_bug():
    assert False
```

## Temporary Directory Fixture

```python
def test_temp_dir(tmpdir):
    file = tmpdir.join("test.txt")
    file.write("hello")
    assert file.read() == "hello"
```

## Capturing Output

```python
def test_output(capsys):
    print("hello")
    captured = capsys.readouterr()
    assert captured.out == "hello\n"
```

## Testing Exceptions

```python
import pytest

def test_raises():
    with pytest.raises(ValueError):
        raise ValueError("This is a ValueError")
```

## Test Coverage

Install `pytest-cov`:

```sh
pip install pytest-cov
```

Run with coverage:

```sh
pytest --cov=yourmodule
```

## Grouping Tests

Create a `conftest.py` for shared fixtures and hooks.

```python
# conftest.py
import pytest

@pytest.fixture
def shared_resource():
    return "resource"
```

## Plugins

Explore available plugins:

```sh
pytest --help
```

Install a plugin:
```sh
pip install pytest-plugin-name
```

## Useful Plugins

- `pytest-cov`: Coverage reporting
- `pytest-xdist`: Distributed testing
- `pytest-mock`: Mocking utilities

## Summary

- **Installation and Basic Usage:** `pip install pytest`, `pytest`
- **Writing Tests:** Functions or classes prefixed with `test_`
- **Fixtures:** Use `@pytest.fixture` to set up test dependencies
- **Marking and Parameterizing:** `@pytest.mark` and `@pytest.mark.parametrize`
- **Mocking:** `unittest.mock` or `pytest-mock`
- **Running Tests with Options:** Use `pytest -v`, `pytest -k "keyword"`, `pytest -m "mark"`
- **Coverage:** `pytest --cov=yourmodule`

## Run pytest in Azure DevOps build pipeline

<https://www.codewrecks.com/post/old/2018/11/run-python-test-with-azure-devops-pipeline/>