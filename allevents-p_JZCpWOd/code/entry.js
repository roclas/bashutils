// To return a custom HTTP response, use $.respond() [requires HTTP trigger]
export default defineComponent({
  async run({ steps, $ }) {
    await $.respond({
      status: 200,
      headers: {},
      body: "hello world!",
    })
  },
})
