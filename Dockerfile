
# Python image
FROM python:3.11.4

# Set Python path and working directory
ENV PYTHONPATH "${PYTHONPATH}:/workspace"
WORKDIR /workspace
# Install zsh
RUN apt-get update && apt-get install -y --no-install-recommends zsh && \
    chsh -s /bin/zsh

# Install Poetry
ENV POETRY_HOME=/opt/poetry
RUN curl -sSL https://install.python-poetry.org/ | python - && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create false


# Copy Python project files and install dependencies
COPY pyproject.toml poetry.lock ./
RUN poetry install


# Create non-root user
ENV USERNAME=atcoder
RUN adduser --disabled-password --gecos '' $USERNAME
USER $USERNAME


# Set zsh and copy zsh configuration
COPY .config/.zshrc /home/$USERNAME/.zshrc
CMD ["/bin/zsh"]
