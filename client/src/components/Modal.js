import { useEffect } from 'react';
import '../assets/css/Modal.css';
import {AiFillAndroid, AiOutlineDownload} from 'react-icons/ai';


const Modal=(props)=>
{
    
    useEffect(()=>{
        document.body.style.overflow='hidden';

        return(()=>{
        document.body.style.overflow='unset';
        })
    },[])
    
    return(
        <>
            <div className="backdrop"
            style={{top:props.yOffset}}
            onClick={()=>{props.onClose(false)}}></div>

            <div className="modal" style={{top:`calc(50% + ${props.yOffset}px)`}}>
                <span>Download the Android app for this leaderboard:</span>
                <a href="https://gcloud.servatom.com/app" target="_blank">
                    <AiOutlineDownload/><span>Download App</span>
                </a>
            </div>
        </>
    )
}

export default Modal;