FROM python:3.7-alpine
COPY . /app
WORKDIR /app
RUN pip install .
RUN internet_application create-db
RUN internet_application populate-db
RUN internet_application add-user -u admin -p admin
EXPOSE 5000
CMD ["internet_application", "run"]
