# API-Testing

[![api tests](https://github.com/lttrung112/karate-google-APIs/actions/workflows/apitests.yml/badge.svg?branch=main)](https://github.com/lttrung112/karate-google-APIs/actions/workflows/apitests.yml)

This is an example project for practice of FunnelBeam

## Detailed specs
Please create tests for some key parts of the following Google Places APIs:
- Call Place Search (findplacefromtext)
- Call Place Details (details)

## Explaination

#### This practice is developed based on [Karate](https://github.com/karatelabs/karate/)
#### CI-CD is based on the Github Action
#### Structure of test designed
    .
    ├── ...
    ├── tests                           # Test files (alternatively `spec` or `feature`)
    │   ├── common                      # common tests for reuses purposes
    │   ├── find-place-from-text-json   # findplacefromtext endpoint, this folder just for json output
    │   ├── place-details-json          # place-details endpoint   this folder just for json output
    │   └── ... 
    └── ...


#### How to use to test

- Access [Github Action](https://github.com/lttrung112/karate-google-APIs/actions)
- Select the workflow you want to test
- Open jobs details to see the status of testing
- Click rerun failed jobs or rerun all jobs if you want to rerun
- To get the test report:
  - Access the Summary -> Artifacts -> Test Reports

#### Sample config steps

```yaml
steps:
- name: Checkout
    uses: actions/checkout@v2.0.0

- name: API tests
    uses: lttrung112/karate-google-APIs@main
    with:
      url: https://maps.googleapis.com/maps/api/place/
      tests: |
        tests/find-place-from-text-json/*.feature
        tests/place-details-json/*.feature
```

#### Some un-completed works
In this limitations of the times for this practice, there are some points I will enhance in the future:
- Still not cover output as xml verification
- In verifying of responses of each test case, need to check more details responses of all attributes
- There are some limitations of test data, I already marked as question in the code.
- The test jobs still have some failed case because some errors in expected results.
- Need to optimize configuration of karate framework such as running in parallel mode, waiting for stable results.
#### References
- [Karate - Github Action](https://github.com/erikbos/karate-action)
- [Karate](https://github.com/karatelabs/karate/)
