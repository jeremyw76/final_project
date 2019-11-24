export default {
  instance: Stripe('pk_test_FTjdbSHNGRt3XRjIOZZYmpRJ00hwbail7N'),
  sessionId: undefined,
  redirectToCheckout (successCallback, errorCallback)  {
    this.instance.redirectToCheckout({
      sessionId: this.sessionId
    }).then(successCallback).catch(errorCallback)
  }
}
