FROM alpine:3.5
MAINTAINER Richard Huang <rickypc@users.noreply.github.com>

ENV TIME_ZONE Asia/Shanghai

RUN apk add --no-cache bash curl dbus firefox-esr fontconfig python3=3.5.6-r0 ttf-freefont xvfb

# Prevent time drift
RUN ntpd -dqnp pool.ntp.org

# Add gecko driver
ARG GECKODRIVER_VERSION=0.22.0
ARG GECKODRIVER_FILE=v${GECKODRIVER_VERSION}/geckodriver-v${GECKODRIVER_VERSION}-linux64.tar.gz
RUN curl -s -o /tmp/geckodriver.tar.gz -L \
  https://github.com/mozilla/geckodriver/releases/download/$GECKODRIVER_FILE \
  && rm -rf /usr/bin/geckodriver \
  && tar -C /usr/bin -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && mv /usr/bin/geckodriver /usr/bin/geckodriver-$GECKODRIVER_VERSION \
  && chmod 755 /usr/bin/geckodriver-$GECKODRIVER_VERSION \
  && echo "${TIME_ZONE}" > /etc/timezone \
  && ln -fs /usr/bin/geckodriver-$GECKODRIVER_VERSION /usr/bin/geckodriver
