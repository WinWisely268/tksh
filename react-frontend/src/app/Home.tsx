import React, {useEffect, useState} from 'react'
// import cx from 'classnames'
import {CircularProgress, Grid, makeStyles} from '@material-ui/core'

import DashboardLayout, {useStyles} from './DashboardLayout'
import {Table} from '../components/Table'
import SnackBar from '../components/Snackbar'
import {useGetReports} from "../shared/hooks/GetReports";
import {grpcClient} from "../shared/service/client";

export interface DashboardTableProps {
}

const useTableStyles = makeStyles({
    root: {
        '& > *': {
            borderBottom: 'unset'
        }
    }
})

function formatMoney(amount: number, decimalCount = 2, decimal = ".", thousands = ",") {
    try {
        decimalCount = Math.abs(decimalCount)
        decimalCount = isNaN(decimalCount) ? 2 : decimalCount

        const negativeSign = amount < 0 ? "-" : ""
        let stringAmount = amount.toString()

        let i = parseInt(stringAmount = Math.abs(Number(amount) || 0).toFixed(decimalCount))
        let iString = i.toString();
        let j = (iString.length > 3) ? iString.length % 3 : 0;

        return negativeSign + (j ? iString.substr(0, j) + thousands : '') + iString.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + thousands) + (decimalCount ? decimal + Math.abs(amount - i).toFixed(decimalCount).slice(2) : "");
    } catch (e) {
        console.log(e)
    }
};


const Dashboard: React.FunctionComponent<DashboardTableProps> = () => {
    useEffect(() => {
        document.title = 'Laporan Perbaikan Kaca'
    }, [])
    const [errMsg, setErrMsg] = useState('')
    const classes = useTableStyles()
    const {isLoading, allReports, errorMsg} = useGetReports(grpcClient.serviceClient)

    const columns = [
        {
            Header: 'Tanggal',
            accessor: 'tanggal',
            fillter: 'fuzzyFilter',
        },
        {
            Header: 'Jumlah',
            accessor: 'jumlah',
            align: 'right',
        }
    ]

    if (isLoading) {
        return (
            <React.Fragment>
                <div style={{display: 'flex', justifyContent: 'center'}}>
                    <CircularProgress/>
                </div>
            </React.Fragment>
        )
    } else if (errorMsg != '') {
        return (
            <React.Fragment>
                <SnackBar
                    variant='error'
                    message={errMsg}
                    setMessage={(message) => setErrMsg(errMsg)}
                />
            </React.Fragment>
        )
    }

    function mapListDataRow(): any[] {
        let transferRecord: any[] = []
        if (
            allReports !== undefined &&
            allReports !== null
        ) {
            // eslint-disable-next-line array-callback-return
            allReports.map((rep) => {
                transferRecord.push({
                    tanggal: rep.getTanggal()?.toDate().toDateString() + ' ' + rep.getTanggal()?.toDate().toTimeString(),
                    jumlah: formatMoney(rep.getTransfer(), 2, ",", ".")
                })
            })
        }

        return transferRecord
    }


    const dashboardPage = () => (
        <React.Fragment>
            <Grid item lg={12} xs={12}>
                <Table
                    name='Data Transfer'
                    columns={columns}
                    data={mapListDataRow()}
                />
            </Grid>
        </React.Fragment>
    )

    return <DashboardLayout children={dashboardPage()}/>
}

export default Dashboard
