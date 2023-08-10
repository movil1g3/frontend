const nodeMailer = require('nodemailer');
var code = 0;

sendMail2 = async () => {

    const config = {
        host: 'smtp.gmail.com',
        port: 587,
        auth: {
            user: 'turciosjimenez@gmail.com',
            pass: 'jizy pnij vrgg hrlj'
        }
    }

    code = generateCodeAccess();
    
    console.log(code);

    const mensaje = {
        from: 'turciosjimenez@gmail.com',
        to: 'carlosoficial15@gmail.com',
        subject: 'Correo De Verificacion de Usuario',
        text: `Este es su codigo de acceso ${code}`
    }

    const transport = nodeMailer.createTransport(config);

    const info = await transport.sendMail(mensaje);

    console.log(info);

}

function generateCodeAccess() {
    return Math.floor(10000 + Math.random() * 90000);
}

sendMail2();