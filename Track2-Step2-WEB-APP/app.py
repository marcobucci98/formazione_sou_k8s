from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return """
    <!DOCTYPE html>
    <html lang="it">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hello World</title>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Titan+One&family=Montserrat:wght@800&display=swap');

            * {
                box-sizing: border-box;
            }

            body {
                margin: 0;
                height: 100vh;
                overflow: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
                /* Mantenuto lo sfondo viola/blu originale */
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                font-family: 'Titan One', cursive, sans-serif;
                position: relative;
            }

            .cloud {
                position: absolute;
                background: rgba(255, 255, 255, 1);
                border-radius: 100px;
                animation: moveClouds linear infinite;
            }

            .cloud::before, .cloud::after {
                content: '';
                position: absolute;
                background: rgba(255, 255, 255, 1);
                border-radius: 50%;
            }

            .cloud1 {
                width: 120px; height: 40px;
                top: 15%; left: -150px;
                animation-duration: 25s;
            }
            .cloud1::before { width: 50px; height: 50px; top: -20px; left: 20px; }
            .cloud1::after { width: 40px; height: 40px; top: -15px; right: 20px; }

            .cloud2 {
                width: 180px; height: 50px;
                top: 45%; left: -200px;
                animation-duration: 18s;
                animation-delay: 4s;
                transform: scale(0.8);
            }
            .cloud2::before { width: 70px; height: 70px; top: -30px; left: 30px; }
            .cloud2::after { width: 50px; height: 50px; top: -20px; right: 30px; }

            .cloud3 {
                width: 150px; height: 45px;
                top: 75%; left: -180px;
                animation-duration: 30s;
                animation-delay: 2s;
                transform: scale(1.1);
            }
            .cloud3::before { width: 60px; height: 60px; top: -25px; left: 25px; }
            .cloud3::after { width: 45px; height: 45px; top: -18px; right: 25px; }

            @keyframes moveClouds {
                0% { left: -200px; }
                100% { left: 100vw; }
            }

            .toy-logo {
                position: relative;
                z-index: 10;
                display: flex;
                flex-direction: column;
                align-items: center;
                transform: rotate(-3deg);
                filter: drop-shadow(0px 12px 15px rgba(0,0,0,0.4));
            }

            .text-top {
                font-size: 6rem;
                color: #FFD100;
                text-transform: uppercase;
                letter-spacing: 2px;
                /* Effetto Bordo Blu e 3D */
                -webkit-text-stroke: 4px #0B4CA0;
                text-shadow: 
                    0px 5px 0px #0B4CA0,
                    3px 7px 0px #08346e,
                    5px 10px 10px rgba(0,0,0,0.5);
                margin-bottom: -15px;
                z-index: 2;
            }

            .text-bottom {
                font-size: 6rem;
                color: #FFD100;
                text-transform: uppercase;
                letter-spacing: 2px;
                /* Effetto Bordo Blu e 3D */
                -webkit-text-stroke: 4px #0B4CA0;
                text-shadow: 
                    0px 5px 0px #0B4CA0,
                    3px 7px 0px #08346e,
                    5px 10px 10px rgba(0,0,0,0.5);
                margin: 0;
            }
        </style>
    </head>
    <body>
        <div class="cloud cloud1"></div>
        <div class="cloud cloud2"></div>
        <div class="cloud cloud3"></div>

        <div class="toy-logo">
            <div class="text-top">HELLO</div>
            <p class="text-bottom">WORLD</p>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
