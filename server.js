import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 3000;

// API Endpoint
app.get('/api/hello', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Hello API</title>
      <style>
        body {
          margin: 0;
          padding: 0;
          font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
          color: white;
        }
        .container {
          background: rgba(255, 255, 255, 0.1);
          backdrop-filter: blur(10px);
          -webkit-backdrop-filter: blur(10px);
          border-radius: 20px;
          padding: 3rem 4rem;
          box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
          border: 1px solid rgba(255, 255, 255, 0.18);
          text-align: center;
          transform: translateY(0);
          transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .container:hover {
          transform: translateY(-5px);
          box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.45);
        }
        h1 {
          font-size: 3rem;
          margin-bottom: 1rem;
          text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }
        p {
          font-size: 1.2rem;
          opacity: 0.9;
          line-height: 1.6;
        }
        .badge {
          display: inline-block;
          padding: 0.5rem 1rem;
          background: rgba(255,255,255,0.2);
          border-radius: 50px;
          margin-top: 2rem;
          font-weight: 600;
          letter-spacing: 1px;
          font-size: 0.9rem;
          text-transform: uppercase;
        }
        @keyframes pulse {
          0% { transform: scale(1); }
          50% { transform: scale(1.05); }
          100% { transform: scale(1); }
        }
        .pulse {
          animation: pulse 2s infinite ease-in-out;
        }
      </style>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap" rel="stylesheet">
    </head>
    <body>
      <div class="container">
        <h1>👋 Hello There!</h1>
        <p>This is your gorgeous new Express API endpoint.</p>
        <p>Serving dynamic HTML straight from the backend.</p>
        <div class="badge pulse">API Status: Online</div>
      </div>
    </body>
    </html>
  `);
});

// Serve static files from the React app build directory
app.use(express.static(path.join(__dirname, 'build')));

// Any other requests return the React app
app.use((req, res) => {
  res.sendFile(path.join(__dirname, 'build', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
