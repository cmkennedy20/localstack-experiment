FROM hashicorp/terraform
RUN apk update \
    && apk add --no-cache aws-cli bash curl python3 py3-pip unzip zip
RUN pip install terraform-local

WORKDIR /opt/tf_home