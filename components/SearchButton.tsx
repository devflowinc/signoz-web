import siteMetadata from '@/data/siteMetadata'
import { TrieveModalSearch, TrieveSDK } from 'trieve-search-component'
import 'trieve-search-component/dist/index.css'

const trieve = new TrieveSDK({
  apiKey: 'tr-l1IRx4Jw0iVICiFdf9NroFwmDWQ4CnEd',
  datasetId: '85bdeb65-44ec-4c9c-9d64-725601ad672a',
})
const SearchButton = () => {
  if (siteMetadata.search) {
    return (
      <TrieveModalSearch
        theme="dark"
        trieve={trieve}
        ButtonEl={() => (
          <button aria-label="Search" className="rounded-full bg-signoz_slate-500 px-2 py-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <circle cx="11" cy="11" r="8"></circle>
              <path d="m21 21-4.3-4.3"></path>
            </svg>
          </button>
        )}
      />
    )
  }
}

export default SearchButton
