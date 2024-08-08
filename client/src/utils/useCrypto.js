import forge from 'node-forge'
import request from '../api'
import { CRYPTO_PADDING } from '../global.config'

/**
 * 使用非对称加密来加密密码
 * @param {*} data 
 * @returns 
 */
export function useCrypto (data) {
  return new Promise((resolve) => {
    request({
      name: 'GetPublicKey'
    }).then(res => {
      const { label, public_key } = res.data.data
      const publicKey = forge.pki.publicKeyFromPem(public_key)
      const messageBytes = forge.util.createBuffer(data, 'utf8').getBytes()
      const encrypted = publicKey.encrypt(messageBytes, 'RSA-OAEP', {
        md: forge.md.sha256.create()
      })
      const encrypted64 = forge.util.encode64(encrypted)
      resolve({
        data: encrypted64,
        label
      })
    })
  })
}

/**
 * base64编码用户名
 * @param {*} data 
 * @returns 
 */
export function useEncode64 (data) {
  const { prefix, suffix } = CRYPTO_PADDING
  return forge.util.encode64(`${prefix}${data}${suffix}`)
}