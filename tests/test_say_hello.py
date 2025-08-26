from say_hello.say_hello import say_hello


def test_say_hello() -> None:
    assert say_hello() == "Hello"
