const http = require('http');
http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Backend Node.js funcionando\n');
}).listen(3000, () => {
    console.log('Servidor en puerto 3000');
});