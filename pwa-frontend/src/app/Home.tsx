import React, { useEffect, useState } from 'react'
import { Grid } from '@material-ui/core'
import DashboardLayout from './DashboardLayout'
import { Table } from '../components/Table'
import SnackBar from '../components/Snackbar'
import { grpcClient } from '../shared/service/client'
import { ReportRequest, TransferRecord } from '../rpc/tksh_pb'
import Typography from '@material-ui/core/Typography'
import dayjs from 'dayjs'

export interface DashboardTableProps {}

function formatDate(dateInput: string): string {
  return dayjs(dateInput).format('DD-MMM-YYYY HH:mm:ss [WIB]')
}

function formatMoney(
  amount: number,
  decimalCount = 2,
  decimal = '.',
  thousands = ',',
  currency: string = 'Rp. '
) {
  try {
    decimalCount = Math.abs(decimalCount)
    decimalCount = isNaN(decimalCount) ? 2 : decimalCount

    const negativeSign = amount < 0 ? '-' : ''

    let i = parseInt(Math.abs(Number(amount) || 0).toFixed(decimalCount))
    let iString = i.toString()
    let j = iString.length > 3 ? iString.length % 3 : 0

    return (
      currency +
      negativeSign +
      (j ? iString.substr(0, j) + thousands : '') +
      iString.substr(j).replace(/(\d{3})(?=\d)/g, '$1' + thousands) +
      (decimalCount
        ? decimal +
          Math.abs(amount - i)
            .toFixed(decimalCount)
            .slice(2)
        : '')
    )
  } catch (e) {
    console.log(e)
  }
}

const Dashboard: React.FunctionComponent<DashboardTableProps> = () => {
  useEffect(() => {
    document.title = 'Laporan Perbaikan Kaca'
  }, [])
  const [errMsg, setErrMsg] = useState('')
  const [allReports, setAllReports] = useState<TransferRecord[] | undefined>(
    undefined
  )
  useEffect(() => {
    ;(async () => {
      try {
        const reportReq = new ReportRequest()
        reportReq.setSortBy('Tanggal')
        const allRecords = await grpcClient.serviceClient.getReport(
          reportReq,
          {}
        )
        setAllReports(allRecords.getReportItemsList())
      } catch (e) {
        setErrMsg(e.valueOf().toString())
      }
    })()
  }, [])

  const columns = [
    {
      Header: 'Tanggal Transfer',
      accessor: 'tanggal',
      fillter: 'fuzzyFilter'
    },
    {
      Header: 'Jumlah Transfer',
      accessor: 'jumlah',
      align: 'right'
    }
  ]

  function mapListDataRow(): any[] {
    let transferRecord: any[] = []
    if (allReports !== undefined && allReports !== null) {
      allReports.map((rep) => {
        transferRecord.push({
          tanggal: formatDate(rep.getTanggal()?.toDate().toISOString()!),
          jumlah: formatMoney(rep.getTransfer(), 2, ',', '.')
        })
      })
    }

    return transferRecord
  }

  const getTotalSaldo = () => {
    let totalSaldo: number = 0.0
    if (allReports !== undefined && allReports !== null) {
      allReports.forEach((rep) => {
        totalSaldo += rep.getTransfer()
      })
    }
    return formatMoney(totalSaldo, 2, ',', '.')
  }

  if (errMsg !== '') {
    return (
      <React.Fragment>
        <SnackBar
          variant='error'
          message={errMsg}
          setMessage={(message) => setErrMsg(errMsg)}
        />
      </React.Fragment>
    )
  } else {
    const dashboardPage = () => (
      <React.Fragment>
        <Grid item lg={12} xs={12}>
          <Table
            name='Data Transfer'
            columns={columns}
            data={mapListDataRow()}
          />
        </Grid>
        <Typography variant='h5' color='textSecondary' align='center'>
          Total Saldo: {getTotalSaldo()}
        </Typography>
      </React.Fragment>
    )

    return <DashboardLayout children={dashboardPage()} />
  }
}

export default Dashboard