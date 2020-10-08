FROM nginx

LABEL maintainer="abdelrhmanhassan882@gmail.com"

RUN rm /usr/share/nginx/html/index.html

# Copy source code to working directory
COPY index.html /usr/share/nginx/html