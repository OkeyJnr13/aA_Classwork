Array.prototype.myEach = function(callback) {
    for(let i = 0; i < this.length; i++){
        callback(this[i]);
    }
}

const arr = [1,2,3,4];

function printNumber(num){
    console.log(`${num}`);
}

let result = arr.myEach(num => printNumber(num));
console.log(result);


Array.prototype.myMap = function(callback){
    let result = [];

    this.myEach(el => result.push(callback(el)))

    return result;
}

console.log(arr.myMap(num => num * 2));


Array.prototype.myReduce = function(callback, initialVal){
    let result = 0;

    if (initialVal !== undefined){
        result = initialVal;
    }


    this.myEach(el => result = callback(result, el));

    return result;
}

// console.log(arr.myReduce( (sum, el) => sum + el )); // without an initial value
console.log(arr.myReduce( (sum, el) => sum + el, 10 )); // with an initial value