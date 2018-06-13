class MyPromise {
    constructor(fn) {
        this._resolve_data = null;
        this._error_data = null;

        this._onFulFilleds = [];
        this._onRejecteds = [];

        this.resolve = this.resolve.bind(this);
        this.reject = this.reject.bind(this);
        this.then = this.then.bind(this);

        // 1: pending
        // 2: fulfilled 
        // -1: rejected
        this.state = 1;
        fn(this.resolve, this.reject);
    }

    resolve() {
        this._resolve_data = arguments;
        this.state = 2;
        for (let i = 0; i < this._onFulFilleds.length; ++i) {
            let result = this._onFulFilleds[i].apply(this, arguments);
            if (result instanceof MyPromise) {
                for (i++; i < this._onFulFilleds.length; ++i) {
                    let onFulFilled = this._onFulFilleds.length > i ? this._onFulFilleds[i] : () => { };
                    let onRejected = this._onRejecteds.length > i ? this._onRejecteds[i] : () => { };
                    result.then(onFulFilled, onRejected);
                }
            }
        }
    }

    reject() {
        this._error_data = arguments;
        this.state = -1;
        for (let i = 0; i < this._onRejecteds.length; ++i) {
            let result = this._onRejecteds[i].apply(this, arguments);
            if (result instanceof MyPromise) {
                for (i++; i < this._onRejecteds.length; ++i) {
                    let onFulFilled = this._onFulFilleds.length > i ? this._onFulFilleds[i] : () => { };
                    let onRejecteds = this._onRejecteds.length > i ? this._onRejecteds[i] : () => { };
                    result.then(onFulFilled, onRejecteds);
                }
            }
        }
    }

    then(onFulFilled, onRejected) {
        if (onFulFilled && onFulFilled instanceof Function) {
            this._onFulFilleds.push(onFulFilled);
        }
        if (onRejected && onRejected instanceof Function) {
            this._onRejecteds.push(onRejected);
        }

        switch (this.state) {
            case 2:
                onFulFilled.apply(this, this._resolve_data);
                break;
            case -1:
                onRejected.apply(this, this._error_data);
                break;
        }
        return this;
    }
}