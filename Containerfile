FROM registry.access.redhat.com/ubi8/nodejs-20@sha256:sha256:c9ce7bcfe894d70a3d872064b2e810413c8f3dd9d7df3b3698fe213ce7d0fd88

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
