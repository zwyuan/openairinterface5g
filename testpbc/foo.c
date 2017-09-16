#include "pbc.h"

element_t g, X, Y, x, y;
pairing_t pairing;
pairing_t pairing2;

int verbose = 1;

int main(void)
{
    /* call PBC functions */

  int rbits = 160;
  int qbits = 512;
  pbc_param_t param;

  // printf("rbits=%d qbits=%d\n",rbits,qbits);

  pbc_param_init_a_gen(param, rbits, qbits);
  pairing_init_pbc_param(pairing, param);

  pbc_param_init_a_gen(param, rbits, qbits);
  pairing_init_pbc_param(pairing2, param);

  pbc_param_clear(param);


  element_t a, b, c, cu, r, A, B, C;
  element_t ax, a1cuxy;
  element_t xy, cuxy;

  element_init_G1(a, pairing);
  element_init_G1(b, pairing);
  element_init_G1(c, pairing);
  element_init_Zr(r, pairing);
  element_init_G1(A, pairing);
  element_init_G1(B, pairing);
  element_init_G1(C, pairing);

  element_init_G1(ax, pairing);
  element_init_G1(a1cuxy, pairing);

  //temporarily regard p and q are independent
  //instead of p = 2q ＋ 1
  element_init_Zr(xy, pairing2);
  element_init_Zr(cuxy, pairing2);
  element_init_Zr(cu, pairing2);

  //temporarily regard cu as a random number in Zr
  //instead of Cu = r^k&^ru
  element_random(cu);
  element_random(a);
  element_printf("sig component a = %B\n", a);
  element_pow_zn(b, a, y);
  element_printf("sig component b = %B\n", b);
  element_pow_zn(ax, a, x);
  element_mul(xy, x, y);
  element_mul(cuxy, xy, cu);
  element_pow_zn(a1cuxy, a, cuxy);
  element_mul(c, ax, a1cuxy);
  element_printf("sig component c = %B\n", c);

  //blind the signature
  element_random(r);
  element_pow_zn(A, a, r);
  element_pow_zn(B, b, r);
  element_pow_zn(C, c, r);
    return 0;
}

