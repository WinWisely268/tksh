import {TkshServiceClient} from '../../rpc/TkshServiceClientPb';

export type GrpcClient = {
    serviceClient: TkshServiceClient,
}

export const grpcClient = {
    serviceClient: new TkshServiceClient(`https://perbaikankaca.fly.dev:443`)
}