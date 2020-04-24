FROM centos
RUN yum install centos-release-scl -y && yum install rh-python36 -y
RUN pip install flask
COPY app.py /opt/
ENTRYPOINT FLASK_APP=/opt/app.py flask run --host=0.0.0.0 --port=8080