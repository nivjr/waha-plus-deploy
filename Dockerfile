FROM devlikeapro/waha-plus:latest

EXPOSE 3000

ENV PORT=3000

CMD ["node", "dist/main.js"]
