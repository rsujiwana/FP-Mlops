import pytest
from app.routes import app

@pytest.fixture()
def app():
    app = create_app()
    app.config.update({
        "TESTING": True,
    })

    # other setup can go here

    yield app

    # clean up / reset resources here


@pytest.fixture()
def client(app):
    return app.test_client()


@pytest.fixture()
def runner(app):
    return app.test_cli_runner()

def test_json_post(client):
    response = client.post('/label', json={
        "data": "This is a sample input text."
    })
    assert response.json["confidence"] >= 0.90