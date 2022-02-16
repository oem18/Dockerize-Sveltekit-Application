FROM node:16-alpine3.14 as build

LABEL owner=""
LABEL description=""
LABEL version=""
LABEL maintainer=""

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install -g pnpm

RUN pnpm install
COPY . .
RUN pnpm run build

FROM build

WORKDIR /app

RUN pnpm install pm2 -g

COPY --from=build /usr/src/app/build .
COPY --from=build /usr/src/app/package.json .
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY ./ecosystem.config.cjs .

EXPOSE 3000

CMD [ "pm2-runtime", "start", "ecosystem.config.cjs" ]
