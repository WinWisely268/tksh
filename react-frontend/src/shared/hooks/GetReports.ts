import {useState, useCallback} from 'react'
import {TkshServiceClient} from '../../rpc/TkshServiceClientPb'
import {ReportAll, ReportRequest, TransferRecord} from '../../rpc/tksh_pb'

export const useGetReports = (client: TkshServiceClient) => {
    const [allReports, setAllReports] = useState<TransferRecord[]>()
    const [isLoading, setLoading] = useState<boolean>(true)
    const [errorMsg, setErrorMsg] = useState<string>('')

    useCallback(() => {
        setLoading(true)
        return new Promise<TransferRecord[]>(async (resolve, reject) => {
            try {
                const reportReq: ReportRequest = new ReportRequest()
                reportReq.setSortBy("Tanggal")
                const {getReportItemsList} = await client.getReport(reportReq, null)
                setAllReports(getReportItemsList)
                setLoading(false)
                resolve(getReportItemsList())
            } catch (e) {
                setLoading(false)
                setErrorMsg(e.toString)
                reject(e.toString())
            }
        })
    }, [client])
    return {
        isLoading,
        allReports,
        errorMsg
    }
}