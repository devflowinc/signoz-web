import siteMetadata from '@/data/siteMetadata'
import { TrieveModalSearch, TrieveSDK } from 'trieve-search-component'
import 'trieve-search-component/dist/index.css'

const trieve = new TrieveSDK({
  apiKey: 'tr-l1IRx4Jw0iVICiFdf9NroFwmDWQ4CnEd',
  datasetId: '85bdeb65-44ec-4c9c-9d64-725601ad672a',
})
const SearchButton = () => {
  if (siteMetadata.search) {
    return <TrieveModalSearch theme="dark" trieve={trieve} />
  }
}

export default SearchButton
