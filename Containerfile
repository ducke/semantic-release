FROM registry.access.redhat.com/ubi8/nodejs-20:1-46

USER 65532

WORKDIR /home/app

RUN mkdir /home/app/.npm-global

# getting error: Your cache folder contains root-owned files
ENV NPM_CONFIG_PREFIX /home/app/.npm-global
ENV NPM_CONFIG_CACHE /home/app/.npm

COPY --chown=65532:65532 package*.json ./

RUN npm install -g npm@"10.5.2" \
&& npm ci && npm cache clean --force

COPY --chown=65532:65532 . .

CMD ["npx", "semantic-release", "--help"]
