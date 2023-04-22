/* 再帰でsplitEveryを実装する */
const splitEvery = (nu: number, arr: string[]) => {
  const loop = (nu: number, arr: string[], acc: string[][]) => {
    if (arr.length === 0) return acc;
    return loop(nu, arr.slice(nu), [...acc, arr.slice(0, nu)]);
  };
  return loop(nu, arr, []);
};
