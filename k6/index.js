import http from "k6/http";
import { check, fail } from 'k6';

export const options = {
  iterations: 100,
  vus: 100,
};

export default function () {
  const res = http.get(__ENV.WP_HOSTNAME);
  check(res, {
    'response code was 200': (res) => res.status == 200,
  });
}
