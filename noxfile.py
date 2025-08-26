import os

import nox

nox.options.default_venv_backend = "uv"

nox.options.sessions = ["lint", "clean", "tests"]


@nox.session
def lint(session: nox.Session) -> None:
    """Check linting"""
    session.install("ruff")
    session.run("ruff", "check")
    session.run("ruff", "format")


@nox.session
def clean(session: nox.Session) -> None:
    """Clean build folder"""
    session.run("rm", "-rf", "dist/", external=True)


@nox.session
def build_and_check_dists(session: nox.Session) -> None:
    """Build and check distribution files"""
    session.run("uv", "build")
    session.run("uv", "tool", "run", "twine", "check", "dist/*")


@nox.session(python=["3.9", "3.10", "3.11", "3.12", "3.13"])
def tests(session: nox.Session) -> None:
    """Run tests"""
    session.install("pytest")
    build_and_check_dists(session)

    generated_files: list[str] = os.listdir("dist/")

    for file in generated_files:
        if file.endswith(".whl"):
            generated_sdist: str = os.path.join("dist/", file)

    session.install(generated_sdist)

    session.run("pytest", "tests/", *session.posargs)
