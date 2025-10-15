FROM devlikeapro/waha-plus:latest

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar o WAHA
CMD ["node", "dist/main.js"]
