FROM debian:13.3-slim

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    npm python3 python3-pip graphviz \
    && rm -rf /var/lib/apt/lists/*

COPY package.json package-lock.json /opt/likec4/
RUN cd /opt/likec4 && npm ci
ENV PATH="/opt/likec4/node_modules/.bin:${PATH}"

COPY requirements-docs.txt /tmp/requirements-docs.txt
RUN pip3 install --break-system-packages -r /tmp/requirements-docs.txt && rm /tmp/requirements-docs.txt

# Copy plugin source and install
COPY . /tmp/mkdocs-likec4/
RUN pip3 install --break-system-packages /tmp/mkdocs-likec4/ && rm -rf /tmp/mkdocs-likec4

WORKDIR /docs
EXPOSE 8000
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000", "--livereload"]
