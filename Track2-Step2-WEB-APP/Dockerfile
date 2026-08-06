FROM python:3.11-alpine

WORKDIR /home

RUN pip install --no-cache-dir flask

COPY app.py /home/app.py

EXPOSE 5000

CMD ["python", "app.py"]

