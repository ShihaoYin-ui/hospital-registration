import { http } from '@kit.NetworkKit';

const BASE_URL = 'http://10.0.2.2:8080';

function buildUrl(path: string, params?: Record<string, string | number>): string {
  let url = BASE_URL + path;
  if (params) {
    const query = Object.keys(params)
      .map(k => `${k}=${encodeURIComponent(String(params[k]))}`)
      .join('&');
    url += '?' + query;
  }
  return url;
}

export class HttpUtil {
  static async get(path: string, params?: Record<string, string | number>): Promise<string> {
    const req = http.createHttp();
    try {
      const resp = await req.request(buildUrl(path, params), { method: http.RequestMethod.GET });
      return resp.result as string;
    } finally {
      req.destroy();
    }
  }

  static async post(path: string, body?: object, params?: Record<string, string | number>): Promise<string> {
    const req = http.createHttp();
    try {
      const resp = await req.request(buildUrl(path, params), {
        method: http.RequestMethod.POST,
        header: { 'Content-Type': 'application/json' },
        extraData: body ? JSON.stringify(body) : undefined
      });
      return resp.result as string;
    } finally {
      req.destroy();
    }
  }

  static async put(path: string, body?: object, params?: Record<string, string | number>): Promise<string> {
    const req = http.createHttp();
    try {
      const resp = await req.request(buildUrl(path, params), {
        method: http.RequestMethod.PUT,
        header: { 'Content-Type': 'application/json' },
        extraData: body ? JSON.stringify(body) : undefined
      });
      return resp.result as string;
    } finally {
      req.destroy();
    }
  }

  static async del(path: string, params?: Record<string, string | number>): Promise<string> {
    const req = http.createHttp();
    try {
      const resp = await req.request(buildUrl(path, params), { method: http.RequestMethod.DELETE });
      return resp.result as string;
    } finally {
      req.destroy();
    }
  }
}
