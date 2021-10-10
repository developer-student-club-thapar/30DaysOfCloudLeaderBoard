import {Line} from 'react-chartjs-2';

const LineChart=(props)=>
{
    const data=
    {

        labels: props.names,
        datasets: [
            {
                label: 'Total',
                fill: false,
                lineTension: 0.5,
                backgroundColor: 'rgb(216,81,64)',
                borderColor: 'rgb(216,81,64)',
                borderWidth: 2,
                data: props.total
            },
            {
            label: 'Track 1',
            fill: false,
            lineTension: 0.5,
            backgroundColor: 'rgb(242, 191, 66)',
            borderColor: 'rgb(242, 191, 66)',
            borderWidth: 2,
            data: props.track1
            },
            {
                label: 'Track 2',
                fill: false,
                lineTension: 0.5,
                backgroundColor: 'rgb(89, 166, 92)',
                borderColor: 'rgb(89, 166, 92)',
                borderWidth: 2,
                data: props.track2
            }
            ]
    };

    let delayed;
    return(
        <div className="linechart">
            <Line
            data={data}
            options={{
                title:{
                display:true,
                text:'GCP Challenge Progress',
                fontSize:20
                },
                legend:{
                display:true,
                position:'top'
                },
                animation: {
                    onComplete: () => {
                      delayed = true;
                    },
                    delay: (context) => {
                      let delay = 0;
                      if (context.type === 'data' && context.mode === 'default' && !delayed) {
                        delay = context.dataIndex * 50 + context.datasetIndex * 100;
                      }
                      return delay;
                    }
            }}}
            />
        </div>
    )
}

export default LineChart;