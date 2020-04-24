FROM centos
RUN dnf clean all && rm -r /var/cache/dnf  && dnf upgrade -y && dnf update -y 
RUN dnf install centos-release-scl -y && dnf install rh-python36 -y
RUN pip install flask
COPY app.py /opt/
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080