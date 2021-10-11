import brackets from "../assets/media/brackets.png";

const Footer = ()=>
{
    return(
        <>
            <div className="footer">
                <img src={brackets} alt="brackets" style ={{width:'100px'}}/>
                <h2>Developers Student Club, TIET Patiala</h2>
            </div>
            <small>Made with ❤️ by <a href="https://servatom.com" target="_blank" rel="noreferrer">Servatom</a> at DSC Patiala</small>
        </>
    )
}

export default Footer;